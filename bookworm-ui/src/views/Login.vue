<template>
  <b-jumbotron header="Sign in" class="w-50 m-auto">
    <b-form @submit.prevent="login">
      <b-form-group id="email-group" label="Email" label-for="email">
        <b-form-input type="email" id="email" v-model="form.email" required/>
      </b-form-group>
      <b-form-group id="password-group" label="Password" label-for="password">
        <b-form-input type="password" id="password" v-model="form.password" required/>
      </b-form-group>
      <b-button type="submit" variant="primary">Sign in</b-button>
    </b-form>
  </b-jumbotron> 
</template>

<script>
export default {
  name: 'Login',

  data() {
    return {
      form: {
        email: '',
        password: ''
      }
    }
  },

  methods: {
    login() {
      this.$http.post('/sessions', this.form).then(resp => {
        window.localStorage.setItem('accessToken', resp.data.access_token);
        this.$router.push('/books');
      }).catch(() => {
        console.log(arguments);
      });
    }
  }
}
</script>
