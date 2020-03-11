function populateTemplate() {
  document.addEventListener('DOMContentLoaded', function () {
    const entryTypeDropdown = document.getElementById('post_post_type_id');
    const initialPostTypeId = entryTypeDropdown.options[entryTypeDropdown.selectedIndex].value;

    const baseUrl = window.location.origin
    const apiUrl = `${baseUrl}/accomplishment_types/${initialAccomplishmentTypeId}.json`

    const description = document.getElementById('post_description');


    function populateDOM(data) {
      description.value = data.description_template;
    }

    function getAccomplishmentType(url) {
      fetch(url)
        .then(response => response.json())
        .then(populateDOM)
        .catch(err => console.log(err));
    }

    // Populate description template on pageload
    if(!description){
      getAccomplishmentType(apiUrl);
    }

    // Populate description template on dropdown change
    entryTypeDropdown.addEventListener('change', function (event) {
      event.preventDefault();

      // Do not overwrite content if some has been populated.
      if(description.value.length == 0){
        const selectedAccomplishmentTypeId = event.target.value;
        const apiUrl = `${baseUrl}/accomplishment_types/${selectedAccomplishmentTypeId}.json`

        getAccomplishmentType(apiUrl);
      }
    })
  });
}
