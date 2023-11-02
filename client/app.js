const root = document.getElementById("root");

const init = async () => {
    root.innerText += "Hello Geoffery"
    const data = await fetch("http://localhost:8080/api/v1/name/Geoffery")

    console.log(data.ok)

    // if(!data.ok) {
    //     root.innerText =  "Hello World";
    // }
    // root.innerText =  await data.text();
}