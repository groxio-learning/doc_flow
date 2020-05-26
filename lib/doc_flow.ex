defmodule DocFlow do
  use GenStateMachine
  @initial_state :new
  
  # api 
  
  def start_link(doc_id) do
    GenStateMachine.start_link DocFlow, {@initial_state, doc_id}
  end
  
  def edit(pid) do
    GenStateMachine.cast pid, :edit
  end
  def submit(pid) do
    GenStateMachine.cast pid, :submit
  end
  def revise(pid) do
    GenStateMachine.cast pid, :revise
  end
  def reject(pid) do
    GenStateMachine.cast pid, :reject
  end
  def accept(pid) do
    GenStateMachine.cast pid, :accept
  end
  
  def get_state(pid) do
    GenStateMachine.call pid, :get_state
  end
  
  # Callbacks

  def handle_event(:cast, :edit, :new, doc_id) do
    {:next_state, :editing, doc_id}
  end

  def handle_event(:cast, :submit, :editing, doc_id) do
    {:next_state, :reviewing, doc_id}
  end

  def handle_event(:cast, :revise, :reviewing, doc_id) do
    {:next_state, :editing, doc_id}
  end

  def handle_event(:cast, :reject, :reviewing, doc_id) do
    {:next_state, :rejected, doc_id}
  end

  def handle_event(:cast, :accept, :reviewing, doc_id) do
    {:next_state, :accepted, doc_id}
  end

  def handle_event({:call, from}, :get_state, state, doc_id) do
    {:next_state, state, doc_id, [{:reply, from, {state, doc_id}}]}
  end
end
