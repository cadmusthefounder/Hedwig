class MessagesList extends React.Component {
  render () {
    const messages = this.props.messages.map(({id, message}) => <li key={id}>{message}</li>);
    return (
      <div className="MessagesList">
        <ul>{ messages }</ul>
      </div>
    );
  }
}

MessagesList.propTypes = {
  messages: React.PropTypes.instanceOf(Immutable.List).isRequired
};
