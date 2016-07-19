class ChatNavigationBar extends React.Component {
  render () {
    const { Link } = ReactRouter;

    return (
      <div className="ChatNavigationBar">
        <nav>
          <Link to={ {pathname: window.location.pathname, query: {master: true}} }>
            <i className="glyphicon glyphicon-chevron-left" />
            Back
          </Link>
        </nav>
      </div>
    );
  }
}
