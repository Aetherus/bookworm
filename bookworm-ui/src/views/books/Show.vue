<template>
  <div>
    <section class="p-3">
      <h2>Basic information</h2>
      <div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Title</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="book.title">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Author</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="book.author">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Published on</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="book.published_on">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">ISBN</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="book.isbn">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Fee</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="book.fee">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Quantity</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="book.quantity">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Available</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="book.available_copies">
          </div>
        </div>
      </div>
    </section>

    <section class="p-3">
      <h2>Loans</h2>
      <b-form inline @submit.prevent="fetchLoans">
        <label>From</label>
        <b-form-datepicker class="ml-1" v-model="loansSearchParams.from" :value-as-date="true"/>
        <label class="ml-2">To</label>
        <b-form-datepicker class="ml-1" v-model="loansSearchParams.to" :value-as-date="true"/>
        <b-button class="ml-2" variant="primary" type="submit">Query loans</b-button>
      </b-form>

      <p class="mt-3">
        <b>Total income:</b> {{totalIncome}}
      </p>

      <b-table :fields="loanFields" :items="loans" class="mt-3"/>
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
      book: {},
      loans: [],
      loansSearchParams: {
        from: null,
        to: null
      },
      loanFields: [
        {key: 'created_at', label: 'Created at', sortable: true},
        {key: 'account.number', label: 'Account number', sortable: true},
        {key: 'account.holder_name', label: 'Account holder', sortable: true},
        {key: 'fee', label: 'Fee', sortable: true}
      ]
    }
  },

  created() {
    this.$http.get(`/books/${this.id}`).then(resp => this.book = resp.data)
  },

  methods: {
    fetchLoans() {
      this.$http.get(`/books/${this.id}/loans`, {params: this.loansSearchParams}).then(resp => this.loans = resp.data)
    }
  },

  computed: {
    totalIncome() {
      return this.loans.reduce((sum, loan) => sum.add(currency(loan.fee)), currency('0'));
    }
  }
}
</script>
