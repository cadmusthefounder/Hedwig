class ChatAppContainer extends React.Component {
  render () {
    const { Router, Route, browserHistory } = ReactRouter;

    return (
      <Router history={ browserHistory }>
        <Route path="/threads/:id/messages" component={ ChatApp } />
      </Router>
    );
  }
}
