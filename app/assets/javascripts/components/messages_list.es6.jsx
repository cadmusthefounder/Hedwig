function classnames() {
  return Array.prototype.map.call(arguments, arg => {
    if (typeof arg === 'string') {
      return arg;
    } else if (Array.isArray(arg)) {
      return arg.join(' ');
    } else {
      return Object.keys(arg).filter(k => arg[k]).join(' ');
    }
  }).join(' ');
}

class MessagesList extends React.Component {
  constructor(props) {
    super(props);
    this.onScroll = this.onScroll.bind(this);
  }

  componentDidMount() {
    const node = ReactDOM.findDOMNode(this);
    node.scrollTop = node.scrollHeight;
    node.addEventListener('scroll', this.onScroll);
  }

  componentWillUpdate(nextProps) {
    const node = ReactDOM.findDOMNode(this);

    const { messages } = this.props;
    const nextMessages = nextProps.messages;

    const firstMessage = messages.first();
    const nextFirstMessage = nextMessages.first();

    const lastMessage = messages.last();
    const nextLastMessage = nextMessages.last();

    const atBottom = node.scrollTop + node.offsetHeight === node.scrollHeight;

    delete this.scrollMode;
    delete this.scrollHeight;
    delete this.scrollTop;

    if (messages.size === 0 || nextMessages.size === 0) {
      this.scrollMode = 'bottom';
    } else if (firstMessage.thread_id !== nextFirstMessage.thread_id) { // Change thread
      this.scrollMode = 'bottom';
    } else if (lastMessage.id !== nextLastMessage.id && atBottom) { // Append and looking at last message
      this.scrollMode = 'bottom';
    } else if (firstMessage.id !== nextFirstMessage.id) { // Prepend
      this.scrollMode = 'stick';
      this.scrollHeight = node.scrollHeight;
      this.scrollTop = node.scrollTop;
    } else if (this.props.loading !== nextProps.loading) {
      this.scrollMode = 'stick';
      this.scrollHeight = node.scrollHeight;
      this.scrollTop = node.scrollTop;
    }
  }

  componentDidUpdate() {
    const node = ReactDOM.findDOMNode(this);

    if (this.scrollMode === 'bottom') {
      node.scrollTop = node.scrollHeight;
    } else if (this.scrollMode === 'stick') {
      node.scrollTop = this.scrollTop + (node.scrollHeight - this.scrollHeight);
    }

    if (node.scrollTop === 0) {
      this.props.loadMore();
    }
  }

  componentWillUnmount() {
    const node = ReactDOM.findDOMNode(this);
    node.removeEventListener('scroll', this.onScroll);
  }

  renderNoContent() {
    return <div className="MessagesList">You have no messages</div>;
  }

  renderLoadingSpinner() {
    if (this.props.loading) {
      return (
        <div className="spinner">
          <i className="glyphicon glyphicon-refresh" />
          <br />
          Loading...
        </div>
      );
    }
  }

  renderContent() {
    const messages = this.props.messages.map(({id, message, user_id}) => {
      return (
        <div key={ id } className={ classnames("message", {sent: user_id === this.props.currentUser})}>
          { message }
        </div>
      );
    });

    return (
      <div className="MessagesList">
        { this.renderLoadingSpinner() }
        { messages }
      </div>
    );
  }

  render() {
    if (this.props.messages.size === 0 && !this.props.loading) {
      return this.renderNoContent();
    } else {
      return this.renderContent();
    }
  }

  onScroll(event) {
    if (event.target.scrollTop === 0 && !this.props.loading && !this.props.completelyLoaded) {
      this.props.loadMore();
    }
  }
}

MessagesList.propTypes = {
  messages: React.PropTypes.instanceOf(Immutable.List).isRequired,
  users: React.PropTypes.instanceOf(Immutable.Map).isRequired,
  currentUser: React.PropTypes.number.isRequired,
  completelyLoaded: React.PropTypes.bool.isRequired,
  loading: React.PropTypes.bool.isRequired,
  loadMore: React.PropTypes.func.isRequired
};
