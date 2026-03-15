window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.type === "toggleVisible") {
        const container = document.getElementById("compass-container");
        if (data.show) {
            container.style.display = "block";
        } else {
            container.style.display = "none";
        }
    }

    if (data.type === "updateCompass") {
        let heading = data.heading;
        let direction = "";

        if (heading >= 337.5 || heading < 22.5) {
            direction = "N";
        } else if (heading >= 22.5 && heading < 67.5) {
            direction = "NE";
        } else if (heading >= 67.5 && heading < 112.5) {
            direction = "E";
        } else if (heading >= 112.5 && heading < 157.5) {
            direction = "SE";
        } else if (heading >= 157.5 && heading < 202.5) {
            direction = "S";
        } else if (heading >= 202.5 && heading < 247.5) {
            direction = "SW";
        } else if (heading >= 247.5 && heading < 292.5) {
            direction = "W";
        } else if (heading >= 292.5 && heading < 337.5) {
            direction = "NW";
        }

        document.getElementById("direction").innerHTML = direction;
    }
});