class ChatApp extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      threads: Immutable.List(),
      messagesStore: Immutable.Map(), // Maps from thread_id to list of messages
      tasks: Immutable.Map(),
      users: Immutable.Map(),
      currentUser: 0
    };

    this.onSend = this.onSend.bind(this);
  }

  componentDidMount() {
    $.get('/threads.json').done(data => {
      const threads = Immutable.List(data.threads).map(thread => new Thread(thread));
      const tasks = Immutable.Map(data.tasks.map(task => [task.id, new Task(task)]));
      const users = Immutable.Map(data.users.map(({id, name}) => [id, name]));

      this.setState({
        threads,
        tasks,
        users,
        currentUser: data.current_user.id
      });
    });

    this.loadMessagesForCurrentThread();

    this.subscription = App.cable.subscriptions.create({
      channel: "ChatChannel",
      thread_id: this.currentThreadID
    }, {
      received: data => {
        const message = new Message(data);
        const {messages} = this.state;

        if (!messages.find(m => m.id === message.id)) {
          this.setState({
            messages: messages.push(message)
          });
        }
      }
    });
  }

  componentDidUpdate() {
    if (!this.state.messagesStore.has(this.currentThreadID())) {
      this.loadMessagesForCurrentThread();
    }
  }

  componentWillUnmount() {
    App.cable.subscriptions.remove(this.subscription);
  }

  render () {
    return (
      <div className="ChatApp">
        <ThreadsList threads={ this.state.threads }
                     tasks={ this.state.tasks }
                     users={ this.state.users }
                     currentUser={ this.state.currentUser } />
        <MessagesDisplay messages={ this.state.messagesStore.get(this.currentThreadID(), Immutable.List()) }
                         users={ this.state.users }
                         onSend={ this.onSend } />
      </div>
    );
  }

  onSend(message) {
    const id = this.currentThreadID();

    csrfToken.then(token => {
      $.post(`/threads/${id}/messages`, {
        authenticity_token: token,
        message: {
          message
        }
      });
    });
  }

  currentThreadID() {
    return +this.props.params.id;
  }

  loadMessagesForCurrentThread() {
    const id = this.currentThreadID();
    const messages = this.state.messagesStore.get(id, Immutable.List());
    const params = {};

    if (messages.size !== 0) {
      params.before = messages.get(0).id;
    }

    $.get(`/threads/${id}/messages.json`, params).done(data => {
      const newMessages = Immutable.List(data).map(message => new Message(message));
      const store = this.state.messagesStore.set(id, newMessages.concat(messages));
      this.setState({
        messagesStore: store
      });
    });
  }
}
