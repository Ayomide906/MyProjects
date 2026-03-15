let locations = [];

window.onload = function () {
    fetch("http://127.0.0.1:5000/get_location_names")
        .then(res => res.json())
        .then(data => {
            locations = data.locations;
        });

    const locationInput = document.getElementById("location");
    const locationList = document.getElementById("location-list");

    locationInput.addEventListener("input", function () {
        const query = this.value.toLowerCase();
        locationList.innerHTML = "";

        if (query.length === 0) return;

        const filtered = locations.filter(loc =>
            loc.toLowerCase().includes(query)
        );

        filtered.forEach(loc => {
            const div = document.createElement("div");
            div.classList.add("dropdown-item");
            div.textContent = loc;
            div.onclick = () => {
                locationInput.value = loc;
                locationList.innerHTML = "";
            };
            locationList.appendChild(div);
        });

        // Add "Other" option
        const other = document.createElement("div");
        other.classList.add("dropdown-item");
        other.textContent = "Other";
        other.onclick = () => {
            locationInput.value = "Other";
            locationList.innerHTML = "";
        };
        locationList.appendChild(other);
    });
};
document.getElementById("predictBtn").onclick = function () {
    const total_sqft = document.getElementById("total_sqft").value;
    const bhk = document.getElementById("bhk").value;
    const bath = document.getElementById("bath").value;
    const area = document.getElementById("area_type").value;
    const location = document.getElementById("location").value;

    const formData = new FormData();
    formData.append("total_sqft", total_sqft);
    formData.append("bhk", bhk);
    formData.append("bath", bath);
    formData.append("area_type", area);
    formData.append("location", location);

    fetch("http://127.0.0.1:5000/predict_home_prices", {
        method: "POST",
        body: formData
    })
        .then(res => res.json())
        .then(data => {
            document.getElementById("result").textContent =
                "Estimated Price: " + data.estimated_price + " Lakhs";
        });
};
