from functools import cached_property

class Cell:

    @cached_property
    def _callbacks(self):
        return set([])

    @property
    def updating(self):
        return self._updating

    def _notify_callbacks(self):
        release_callbacks = []

        for callback in self._callbacks:
            release = callback(self.value)
            if callable(release):
                release_callbacks.append(release)

        for release in release_callbacks:
            release()

    def add_callback(self, callback):
        self._callbacks.add(callback)

    def remove_callback(self, callback):
        self._callbacks.discard(callback)


class InputCell(Cell):
    def __init__(self, initial_value):
        self._value = initial_value

    @property
    def value(self):
        return self._value

    @value.setter
    def value(self, new_val):
        if new_val != self._value:
            self._value = new_val
            self._notify_callbacks()


class ComputeCell(Cell):
    def __init__(self, inputs, compute_function):
        self._inputs = inputs
        self._compute_function = compute_function
        for input_ in self._inputs:
            input_.add_callback(
                ReleasableCallback(
                    self._recalculate,
                    self._notify_on_change
                )
            )
        self._previous_value = self.value

    def _recalculate(self):
        del self.value

    def _notify_on_change(self, value=None):
        new_value = self.value
        if new_value != self._previous_value:
            self._previous_value = new_value
            self._notify_callbacks()

    @cached_property
    def value(self):
        return self._compute_function([
            input_.value for input_ in self._inputs
        ])


class ReleasableCallback:

    def __init__(self, notify, release):
        self._notify = notify
        self._release = release

    def __call__(self, value=None):
        self._notify()
        return self._release
