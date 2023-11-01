const root = document.getElementById("root");

const init = async () => {
    const data = await fetch("http://localhost:8080/api/v1/name/Geoffery")
    root.innerText =  await data.text();
}