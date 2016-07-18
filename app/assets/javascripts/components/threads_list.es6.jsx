class ThreadsList extends React.Component {
  renderListItem(thread) {
    const task = this.props.tasks.get(thread.task_id);
    const userID = task.user_id + thread.user_id - this.props.currentUser; // :)
    const user = this.props.users.get(userID);

    const { Link } = ReactRouter;

    return (
      <Link className="item"
            key={ thread.id }
            to={ `/threads/${thread.id}/messages`}
            activeClassName="active">
        { user }
        <br />
        { `${task.from_address}, ${task.from_postal_code} ` }
        <i className="glyphicon glyphicon-arrow-right" />
        { ` ${task.to_address}, ${task.to_postal_code}` }
      </Link>
    );
  }

  render () {
    return (
      <div className="ThreadsList">
        { this.props.threads.map(thread => this.renderListItem(thread)) }
      </div>
    );
  }

  onListClick(id) {
    this.context.router.push(`/threads/${id}/messages`);
  }
}

ThreadsList.propTypes = {
  threads: React.PropTypes.instanceOf(Immutable.List).isRequired,
  tasks: React.PropTypes.instanceOf(Immutable.Map).isRequired,
  users: React.PropTypes.instanceOf(Immutable.Map).isRequired,
  currentUser: React.PropTypes.number.isRequired
};

ThreadsList.contextTypes = {
  router: React.PropTypes.object.isRequired
};
