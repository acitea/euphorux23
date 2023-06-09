<template>
<div class="gallery">
    <h1 style="margin-bottom: 0.5em;">2022's Euphorux</h1>
    <img v-for="image in images" :src="image.pathLong" loading="lazy">
    <div>
        <!-- <stack :column-min-width="320" :gutter-width="8" :gutter-height="8" monitor-images-loaded>
            <stack-item class="img-container" v-for="image in images">
            </stack-item>
        </stack> -->
    </div>
</div>
</template>

<script>
import { Stack, StackItem } from 'vue-stack-grid';
import Lightgallery from 'lightgallery/vue';

export default {
    name: "gallery",
    components: {
        Stack,
        StackItem,
        Lightgallery
    },
    data() {
        return {
            images: []
        }
    },
    mounted () {
        this.importAll(require.context('../../public/mkting', false, /\.png$/));
        return
    },
    methods : {
        importAll(r) {
        r.keys().forEach(key => (this.images.push({ pathLong: r(key), pathShort: key })));
    },
    }
}
</script>

<style scoped>

h1 {
    font-size: 3em;
}

.img-container {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: center;
  overflow: hidden;
  margin: 0;
  object-fit: fill;
  cursor: pointer;
}

.img-container img {
  display: block;
  margin: 0;
  width: 100%;
  height: auto;
}

img {
    width: 90%;
    border: white solid 2px;
}

</style>