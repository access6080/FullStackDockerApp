const root = document.getElementById("root");

const init = async () => {
    //fetch data
    const data = await fetch("/api/v1/name/Geoffery")

    if(!data.ok) {
        root.innerText =  "Hello World";
        return
    }
    root.innerText =  await data.text();
}
