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

    this.chatChannelSubscription = App.cable.subscriptions.create({
      channel: "ChatChannel"
    }, {
      received: data => {
        const message = new Message(data);
        const threadID = message.thread_id;
        let messages = this.state.messagesStore.get(threadID, Immutable.List());

        if (!messages.find(m => m.id === message.id)) {
          messages = messages.push(message).sortBy(m => m.created_at);

          let { threads } = this.state;
          const threadIndex = threads.findIndex(t => t.id === threadID);
          const thread = threads.get(threadIndex).set("last_sent_at", messages.last().created_at);
          threads = threads.set(threadIndex, thread).sort((a, b) => {
            if (a.last_sent_at - b.last_sent_at) {
              return a.last_sent_at - b.last_sent_at;
            } else if (a.created_at - b.created_at) {
              return a.created_at - b.created_at;
            } else {
              return a.id - b.id;
            }
          }).reverse();

          this.setState({
            messagesStore: this.state.messagesStore.set(threadID, messages),
            threads
          });
        }
      }
    });

    const self = this;

    this.threadChannelSubscription = App.cable.subscriptions.create({
      channel: "ThreadChannel"
    }, {
      connected() {
        this.markAsRead(self.currentThreadID());
      },
      received({action, id}) {
        let { threads } = self.state;
        const index = threads.findIndex(t => t.id === id);

        if (action === "mark_as_read") {
          threads = threads.setIn([index, "read"], true);
        } else if (id === self.currentThreadID()) {
          this.markAsRead(id);
        } else {
          threads = threads.setIn([index, "read"], false);
        }

        self.setState({threads});
      },
      markAsRead(id) {
        this.perform("mark_as_read", {id});
      }
    });
  }

  componentDidUpdate() {
    if (!this.state.messagesStore.has(this.currentThreadID())) {
      this.loadMessagesForCurrentThread();
    }

    const { threads } = this.state;
    const index = threads.findIndex(t => t.id === this.currentThreadID());
    if (index !== -1 && !threads.get(index).read) {
      this.threadChannelSubscription.markAsRead(this.currentThreadID());
    }
  }

  componentWillUnmount() {
    App.cable.subscriptions.remove(this.chatChannelSubscription);
    App.cable.subscriptions.remove(this.threadChannelSubscription);
  }

  render () {
    let pane = "detail";

    if ("master" in this.props.location.query) {
      pane = "master"
    }

    return (
      <div className={ `ChatApp ${pane}` }>
        <div className="master-pane">
          <ThreadsList threads={ this.state.threads }
                       tasks={ this.state.tasks }
                       users={ this.state.users }
                       currentUser={ this.state.currentUser } />
        </div>

        <div className="detail-pane">
          <ChatNavigationBar />
          <MessagesList messages={ this.state.messagesStore.get(this.currentThreadID(), Immutable.List()) }
                        users={ this.state.users }
                        currentUser={ this.state.currentUser }
                        completelyLoaded={ this.state.completelyLoadedThreads.has(this.currentThreadID()) }
                        loading={ this.state.loadingThreads.has(this.currentThreadID()) }
                        loadMore={ this.loadMessagesForCurrentThread }/>
          <MessageForm onSend={ this.onSend } />
        </div>
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
