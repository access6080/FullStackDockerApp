const root = document.getElementById("root");

const init = async () => {
    //fetch data
    try {
        const data = await fetch("http://localhost:8080/api/v1/name/Geoffery")
        root.innerText =  await data.text();
    } catch (e) {

        console.log(e)
        root.innerText =  "Hello World";
    }
    
    
}
