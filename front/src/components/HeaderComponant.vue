<template>
  <header id="header">
    <h2 id="title">TIME MANAGER</h2>
    <img id="profile-img" src="profile.svg" width="50px" height="50px" />
  </header>
</template>

<script>
export default {
  name: "HeaderComponant",
};
</script>

<style scoped>
#title {
    font-size: 40px;
    font-weight: bold;
    color: white;
    cursor: pointer
}
#profile-img {
    cursor: pointer;
}
#header {
    background-color: rgb(42, 42, 42);
    padding: 9px;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    font-family: 'Inter', sans-serif;
}
</style>
