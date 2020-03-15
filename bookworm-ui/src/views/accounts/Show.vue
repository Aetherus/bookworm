<template>
  <div>
    <section class="p-3">
      <h2>Basic information</h2>
      <div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Account number</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="account.number">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Holder</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="account.holder_name">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Balance</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="account.balance">
          </div>
        </div>
      </div>
    </section>

    <section class="p-3">
      <h2>Loans</h2>

      <b-button variant="primary" v-b-modal.new-loan class="mt-3">New loan</b-button>
      <b-modal id="new-loan" title="Select a book" @ok="createLoan" @show="loadBooks">
        <b-form @submit.prevent="">
          <b-form-group>
            <b-form-select
              v-model="book_id_for_new_loan"
              :options="books"
              value-field="id"
              text-field="title"
              required
              placeholder="Select a book"
            />
          </b-form-group>
        </b-form>
      </b-modal>

      <p class="mt-3">
        <b>Total amount:</b> {{totalAmount}}
      </p>

      <b-table :fields="loanFields" :items="account.loans" class="mt-3">
        <template v-slot:cell(actions)="data">
          <b-button :key="data.item.id" variant="danger" @click="conclude(data.item)" v-if="!data.item.concluded_at">Conclude!</b-button>
        </template>
      </b-table>
    </section>

    <router-link to="/books">&lt; Back</router-link>
  </div>
</template>

<script>
import currency from 'currency.js'

export default {
  props: ['id'],
  data() {
    return {
      account: {
        number: null,
        holder_name: null,
        balance: null,
        loans: []
      },
      books: [],
      book_id_for_new_loan: null,
      loansSearchParams: {
        from: null,
        to: null
      },
      loanFields: [
        {key: 'created_at', label: 'Created at', sortable: true},
        {key: 'book.title', label: 'Book title', sortable: true},
        {key: 'book.isbn', label: 'ISBN', sortable: true},
        {key: 'fee', label: 'Fee', sortable: true},
        {key: 'actions', label: '', sortable: false}
      ]
    }
  },

  created() {
    this.reload();
  },

  computed: {
    totalAmount() {
      return this.account.loans.reduce((sum, loan) => sum.add(currency(loan.fee)), currency('0'));
    }
  },

  methods: {
    reload() {
      this.$http.get(`/accounts/${this.id}`).then(resp => this.account = resp.data)
    },

    createLoan() {
      this.$http.post('/loans', {account_id: this.id, book_id: this.book_id_for_new_loan}).then(() => this.reload());
    },

    conclude(loan) {
      if (window.confirm('Are you sure?')) {
        this.$http.patch(`/loans/${loan.id}/conclude`).then(() => this.reload());
      }
    },

    loadBooks() {
      this.$http.get('/books').then(resp => this.books = resp.data);
    }
  }
}
</script>

