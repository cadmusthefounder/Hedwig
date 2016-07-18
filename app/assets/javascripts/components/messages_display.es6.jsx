class MessagesDisplay extends React.Component {
  render () {
    return (
      <div className="MessagesDisplay">
        <MessagesList messages={ this.props.messages }
                      users={ this.props.users }
                      currentUser={ this.props.currentUser }
                      completelyLoaded={ this.props.completelyLoaded }
                      loading={ this.props.loading }
                      loadMore={ this.props.loadMore }/>
        <MessageForm onSend={ this.props.onSend } />
      </div>
    )
  }
}

MessagesDisplay.propTypes = {
  messages: React.PropTypes.instanceOf(Immutable.List).isRequired,
  users: React.PropTypes.instanceOf(Immutable.Map).isRequired,
  currentUser: React.PropTypes.number.isRequired,
  onSend: React.PropTypes.func.isRequired,
  completelyLoaded: React.PropTypes.bool.isRequired,
  loading: React.PropTypes.bool.isRequired,
  loadMore: React.PropTypes.func.isRequired
};
