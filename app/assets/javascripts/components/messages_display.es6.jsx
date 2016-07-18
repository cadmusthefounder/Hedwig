class MessagesDisplay extends React.Component {
  render () {
    return (
      <div className="MessagesDisplay">
        <MessagesList messages={ this.props.messages } users={ this.props.users } />
        <MessageForm onSend={ this.props.onSend } />
      </div>
    )
  }
}

MessagesDisplay.propTypes = {
  messages: React.PropTypes.instanceOf(Immutable.List).isRequired,
  users: React.PropTypes.instanceOf(Immutable.Map).isRequired,
  onSend: React.PropTypes.func.isRequired
};
