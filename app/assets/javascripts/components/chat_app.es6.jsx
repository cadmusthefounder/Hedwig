class ChatApp extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      threads: Immutable.List(),
      messagesStore: Immutable.Map(), // Maps from thread_id to list of messages
      tasks: Immutable.Map(),
      users: Immutable.Map(),
      loadingThreads: Immutable.Set(),
      completelyLoadedThreads: Immutable.Set(),
      currentUser: 0
    };

    this.onSend = this.onSend.bind(this);
    this.loadMessagesForCurrentThread = this.loadMessagesForCurrentThread.bind(this);
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
      channel: "ChatChannel"
    }, {
      received: data => {
        const message = new Message(data);
        const messages = this.state.messagesStore.get(this.currentThreadID(), Immutable.List());

        if (!messages.find(m => m.id === message.id)) {
          this.setState({
            messagesStore: this.state.messagesStore.set(this.currentThreadID(), messages.push(message))
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
                         currentUser={ this.state.currentUser }
                         onSend={ this.onSend }
                         completelyLoaded={ this.state.completelyLoadedThreads.has(this.currentThreadID()) }
                         loading={ this.state.loadingThreads.has(this.currentThreadID()) }
                         loadMore={ this.loadMessagesForCurrentThread }/>
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

    if (this.state.loadingThreads.has(id)) {
      return;
    }

    if (this.state.completelyLoadedThreads.has(id)) {
      return;
    }

    this.setState({
      loadingThreads: this.state.loadingThreads.add(id)
    });

    const messages = this.state.messagesStore.get(id, Immutable.List());
    const params = {};

    if (messages.size !== 0) {
      params.before = messages.get(0).id;
    }

    $.get(`/threads/${id}/messages.json`, params).done(data => {
      const newMessages = Immutable.List(data).map(message => new Message(message));
      const store = this.state.messagesStore.set(id, newMessages.concat(messages));
      let { completelyLoadedThreads } = this.state;

      if (data.length === 0) {
        completelyLoadedThreads = completelyLoadedThreads.add(id);
      }

      this.setState({
        messagesStore: store,
        loadingThreads: this.state.loadingThreads.remove(id),
        completelyLoadedThreads
      });
    });
  }
}
