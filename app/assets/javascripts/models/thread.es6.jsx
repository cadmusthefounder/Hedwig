const BaseThread = Immutable.Record({
  id: undefined,
  task_id: undefined,
  user_id: undefined,
  last_sent_at: undefined,
  created_at: undefined,
  updated_at: undefined
});

class Thread extends BaseThread {
  constructor(properties) {
    super(Object.assign({}, properties, {
      last_sent_at: new Date(properties.last_sent_at),
      created_at:   new Date(properties.created_at),
      updated_at:   new Date(properties.updated_at)
    }));
  }
}
