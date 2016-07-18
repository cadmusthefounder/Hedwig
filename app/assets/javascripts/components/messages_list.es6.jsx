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
  renderNoContent() {
    return <div className="MessagesList">You have no messages</div>;
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
        { messages }
      </div>
    );
  }

  render() {
    if (this.props.messages.size === 0) {
      return this.renderNoContent();
    } else {
      return this.renderContent();
    }
  }
}

MessagesList.propTypes = {
  messages: React.PropTypes.instanceOf(Immutable.List).isRequired,
  users: React.PropTypes.instanceOf(Immutable.Map).isRequired,
  currentUser: React.PropTypes.number.isRequired
};
