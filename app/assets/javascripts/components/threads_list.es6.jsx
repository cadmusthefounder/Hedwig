class ThreadsList extends React.Component {
  render () {
    const { Link } = ReactRouter;

    const threads = this.props.threads.map(thread => {
      return (
        <li key={ thread.id }>
          <Link to={ `/threads/${thread.id}/messages` } activeClassName="active">
            { thread.id } - { thread.task_id } - { thread.user_id }
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
  threads: React.PropTypes.instanceOf(Immutable.List).isRequired
};
