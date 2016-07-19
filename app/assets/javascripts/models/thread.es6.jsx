const BaseThread = Immutable.Record({
  id: undefined,
  task_id: undefined,
  user_id: undefined,
  created_at: undefined,
  updated_at: undefined
});

class Thread extends BaseThread {
  constructor(properties) {
    super(Object.assign({}, properties, {
      created_at: new Date(properties.created_at),
      updated_at: new Date(properties.updated_at)
    }));
  }
}
