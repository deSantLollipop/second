<template>
  <div>
    <br>
    <h1>All our posts :</h1>
    <br>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <% @post.each do |post| %>
        <div class="col post_continer">
          <div class="card h-100">
            <div class="card-body" >
              <h3 class="card-title"><%= post.title %></h3>
              <div class="a">
                <p class="card-text"><%= post.body %></p>
              </div>
              <br>
              <%= link_to "Continue reading..", post_path(post), class: 'btn btn-outline-primary' %>
            </div>
          </div>
        </div>
      <% end %>
    </div>
  </div>
</template>

<script>
</script>


<style>
@import '~bootstrap/dist/css/bootstrap.css';

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

</style>
