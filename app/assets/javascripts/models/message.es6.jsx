const BaseMessage = Immutable.Record({
  id: undefined,
  message: undefined,
  user_id: undefined,
  thread_id: undefined,
  created_at: undefined,
  updated_at: undefined
});

class Message extends BaseMessage {
  constructor(properties) {
    super(Object.assign({}, properties, {
      thread_id: properties.interest_id,
      created_at: new Date(properties.created_at),
      updated_at: new Date(properties.updated_at)
    }));
  }
}
