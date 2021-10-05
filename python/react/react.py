
class Cell:

    def __init__(self):
        self._callbacks = set([])

    def _notify_callbacks(self):
        for callback in self._callbacks:
            callback(self.value)

    def add_callback(self, callback):
        self._callbacks.add(callback)

    def remove_callback(self, callback):
        self._callbacks.discard(callback)


class InputCell(Cell):
    def __init__(self, initial_value):
        super().__init__()
        self._value = initial_value
        self._dirty = False

    @property
    def value(self):
        return self._value

    @property
    def dirty(self):
        return self._dirty

    @value.setter
    def value(self, new_val):
        if new_val != self._value:
            self._value = new_val
            self._dirty = True
            try:
                self._notify_callbacks()
            finally:
                self._dirty = False


class ComputeCell(Cell):
    def __init__(self, inputs, compute_function):
        super().__init__()
        self._inputs = inputs
        self._compute_function = compute_function
        for input_ in self._inputs:
            input_.add_callback(self._notify_on_change)
        self._previous_value = self.value

    def _notify_on_change(self, value=None):
        new_value = self.value
        if new_value != self._previous_value:
            self._previous_value = new_value
            self._notify_callbacks()

    @property
    def dirty(self):
        return any(inp.dirty for inp in self._inputs)

    def _compute_value(self):
        return self._compute_function([
            input_.value for input_ in self._inputs
        ])

    @property
    def value(self):
        if self.dirty or not hasattr(self, "_cached_value"):
            self._cached_value = self._compute_value()
        return self._cached_value
