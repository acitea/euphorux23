<template>
    <label class="checkbox">
    <input type="checkbox" :value="value" v-model="model" :checked="checked">
    <svg viewBox="0 0 64 64" height="1em" width="1em">
        <path d="M 0 16 V 56 A 8 8 90 0 0 8 64 H 56 A 8 8 90 0 0 64 56 V 8 A 8 8 90 0 0 56 0 H 8 A 8 8 90 0 0 0 8 V 16 L 32 48 L 64 16 V 8 A 8 8 90 0 0 56 0 H 8 A 8 8 90 0 0 0 8 V 56 A 8 8 90 0 0 8 64 H 56 A 8 8 90 0 0 64 56 V 16" pathLength="575.0541381835938" class="path"></path>
    </svg>
    </label>
</template>

<script>

//import

export default {
    name: "checkbox",
    props: {
        modelValue: { type: [Array, Boolean] },
        value: { type: [Boolean, String] },
        checked : { 
            type : Boolean,
            default : true
        }
    },
    computed: {
        model: {
            get() {
                return this.modelValue;
            },
            set(value) {
                this.$emit("update:modelValue", value);
            },
        }
    }
}
</script>

<style scoped>
.checkbox{
    width: auto;
    display: flex;
    justify-content: center;
}

.checkbox input {
    display: none;
}

.checkbox svg {
    overflow: visible;
}

.checkbox path {
    fill: none;
    stroke: white;
    stroke-width: 8;
    stroke-linecap: round;
    stroke-linejoin: round;
    transition: stroke-dasharray 0.2s ease, stroke-dashoffset 0.2s, stroke 0.3s;
    stroke-dasharray: 241 9999999;
    stroke-dashoffset: 0;
}

.checkbox input:checked ~ svg .path {
    stroke: #0FFF50;
    stroke-dasharray: 70.5096664428711 9999999;
    stroke-dashoffset: -262.2723388671875;
}
</style>