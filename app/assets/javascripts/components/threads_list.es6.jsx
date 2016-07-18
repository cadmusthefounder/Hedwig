class ThreadsList extends React.Component {
  render () {
    const { Link } = ReactRouter;

    const threads = this.props.threads.map(thread => {
      const task = this.props.tasks.get(thread.task_id);
      const userID = task.user_id + thread.user_id - this.props.currentUser; // :)
      const user = this.props.users.get(userID);
      return (
        <li key={ thread.id }>
          <Link to={ `/threads/${thread.id}/messages` } activeClassName="active">
            { user }
            <br />
            { `From: ${task.from_address}, ${task.from_postal_code} ` }
            <br />
            { `To: ${task.to_address}, ${task.to_postal_code}` }
          </Link>
        </li>
      );
    });

    return (
      <div className="ThreadsList">
        <ul>
          { threads }
        </ul>
      </div>
    );
  }
}

ThreadsList.propTypes = {
  threads: React.PropTypes.instanceOf(Immutable.List).isRequired,
  tasks: React.PropTypes.instanceOf(Immutable.Map).isRequired,
  users: React.PropTypes.instanceOf(Immutable.Map).isRequired,
  currentUser: React.PropTypes.number.isRequired
};
