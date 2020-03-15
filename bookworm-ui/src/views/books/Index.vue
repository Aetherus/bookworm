<template>
  <div>
    <h2>Books</h2>
    <router-link to="/books/new" class="btn btn-primary mb-3">New book</router-link>
    <b-table striped hover :fields="fields" :items="books" class="bookworm-clickable-table"
             @row-clicked="book => $router.push(`/books/${book.id}`)">
      <template v-slot:cell(quantity)="data">
        <quick-edit :value="data.item.quantity"
                    button-ok-text="✓"
                    button-cancel-text="×"
                    :classes="{input: 'form-control', buttonOk: 'btn btn-success', buttonCancel: 'btn btn-outline-secondary'}"
                    @input="value => updateQuantity(data.item, value)"/>
      </template>
    </b-table>
  </div>
</template>

<script>
import QuickEdit from 'vue-quick-edit';

export default {
  components: { QuickEdit },
  data() {
    return {
      fields: [
        {key: 'title', label: 'Title', sortable: true},
        {key: 'author', label: 'Author', sortable: true},
        {key: 'published_on', label: 'Published on', sortable: true},
        {key: 'isbn', label: 'ISBN', sortable: true},
        {key: 'fee', label: 'Fee', sortable: true},
        {key: 'quantity', label: 'Quantity', sortable: true}
      ],

      books: []
    }
  },

  created() {
    this.$http.get('/books').then(resp => this.books = resp.data);
  },

  methods: {
    updateQuantity(book, quantity) {
      this.$http.patch(`/books/${book.id}`, {book: {quantity}}).then(() => book.quantity = quantity);
    }
  }
}
</script>

