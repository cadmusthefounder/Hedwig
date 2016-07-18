class MessagesList extends React.Component {
  render () {
    const messages = this.props.messages.map(({id, message, user_id}) => {
      return <li key={id}>
        {this.props.users.get(user_id)} - {message}
      </li>
    });

    return (
      <div className="MessagesList">
        <ul>{ messages }</ul>
      </div>
    );
  }
}

MessagesList.propTypes = {
  messages: React.PropTypes.instanceOf(Immutable.List).isRequired,
  users: React.PropTypes.instanceOf(Immutable.Map).isRequired,
};
