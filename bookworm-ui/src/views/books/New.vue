<template>
  <div>
    <h2>New Book</h2>
    <b-form @submit.prevent="createBook">
      <b-form-group label="ISBN" description="ISBN is required">
        <b-form-input
          v-model="book.isbn"
          required
          placeholder="xxx-x-xx-xxxxxx-x"
        />
      </b-form-group>
      <b-form-group label="Title" description="Title is required">
        <b-form-input
          v-model="book.title"
          required
          placeholder="Zenith of Algorab"
        />
      </b-form-group>
      <b-form-group label="Author">
        <b-form-input
          v-model="book.author"
          placeholder="John Doe"
        />
      </b-form-group>
      <b-form-group label="Published on">
        <b-form-datepicker value-as-date
          v-model="book.published_on"
        />
      </b-form-group>
      <b-form-group label="Quantity">
        <b-form-input
          type="number"
          min="0"
          v-model="book.quantity"
          placeholder="42"
        />
      </b-form-group>
      <b-form-group label="Fee">
        <b-form-input
          type="number"
          min="0.00"
          step="0.01"
          v-model="book.fee"
          placeholder="3.49"
        />
      </b-form-group>
      <b-button type="submit" variant="primary">Create</b-button>
    </b-form>
    <router-link to="/books">&lt; Back</router-link>
  </div>
</template>

<script>
export default {
  data() {
    return {
      book: {
        isbn: null,
        title: null,
        author: null,
        published_on: new Date(),
        quantity: 0,
        fee: '0.00'
      }
    }
  },

  methods: {
    createBook() {
      this.$http.post('/books', this.book).then(() => this.$router.push('/books'));
    }
  }
}
</script>
