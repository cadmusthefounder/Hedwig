class MessageForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      message: ''
    };

    this.onMessageChange = this.onMessageChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
  }

  render () {
    return (
      <div className="MessageForm">
        <form onSubmit={ this.onSubmit }>
          <input type="text"
                 className="form-control"
                 placeholder="Hello!"
                 value={ this.state.message }
                 onChange={ this.onMessageChange } />
          <button className="btn btn-success">Send</button>
        </form>
      </div>
    );
  }

  onMessageChange(event) {
    this.setState({
      message: event.target.value
    });
  }

  onSubmit(event) {
    event.preventDefault();

    this.props.onSend(this.state.message);

    this.setState({
      message: ''
    });
  }
}

MessageForm.propTypes = {
  onSend: React.PropTypes.func.isRequired
};
