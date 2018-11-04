<template>
    <section class="section">
        <div class="columns">
            <div class="column is-3">
                <Menu/>
            </div>
            <div class="column is-6">
                <h1 class="title">Latest Posts</h1>

                <h3
                    v-for="post in allPosts"
                    :key="post.id"
                    class="title is-5">
                        <router-link :to="post.slug">
                            {{ post.title }}
                        </router-link>
                </h3>
            </div>
        </div>
    </section>
</template>

<script>
import { ALL_POSTS_QUERY } from "@/graphql";
import Menu from "@/components/Menu";

export default {
  name: "Home",
  components: {
    Menu
  },
  data() {
    return {
      allPosts: []
    };
  },
  apollo: {
    // fetch all posts
    allPosts: {
      query: ALL_POSTS_QUERY
    }
  }
};
</script>