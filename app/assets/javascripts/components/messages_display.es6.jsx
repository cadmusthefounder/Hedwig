class MessagesDisplay extends React.Component {
  render () {
    return (
      <div className="MessagesDisplay">
        <MessagesList messages={ this.props.messages } />
        <MessageForm onSend={ this.props.onSend } />
      </div>
    )
  }
}

MessagesDisplay.propTypes = {
  messages: React.PropTypes.instanceOf(Immutable.List).isRequired,
  onSend: React.PropTypes.func.isRequired
};
