<template>
  <div class="create-event-popup-veil">
    <form class="create-event-popup">
      <div class="create-event-input-wrapper">
        <div class="create-event-input-title">
          Description
        </div>
        <input v-model="event.title"
               type="text"
               class="create-event-input"
               required>
      </div>

      <div class="create-event-input-wrapper">
        <div class="create-event-input-title">
          Event duration(days)
        </div>
        <input v-model="event.duration"
               type="number"
               class="create-event-input"
               required>
      </div>

      <button @click="submit" class="cal-btn">Create</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      event: {}
    }
  },

  methods: {
    submit(e) {
      e.preventDefault()
      if (e.currentTarget.form.reportValidity()) {
        this.$emit('createEvent', this.event)
      }
    }
  }
}
</script>

<style scoped lang="scss">
@import "~CommonStyles/mixins";
@import "~CalendarStyles";

.create-event-popup-veil {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: rgba(1, 1, 1, 0.4);
  z-index: 1;
}

.create-event-popup {
  @include middle-align-child;
  width: 300px;
  height: 150px;
  background-color: white;
  border-radius: 4px;
  padding: 30px;
}

.create-event-input-wrapper {
  margin-bottom: 10px;
}

.create-event-input-title {
  margin: 0 0 10px 0;
}

.create-event-input {
  width: 100%;
  height: 30px;
  outline: none;
  border-radius: 2px;
}
</style>
