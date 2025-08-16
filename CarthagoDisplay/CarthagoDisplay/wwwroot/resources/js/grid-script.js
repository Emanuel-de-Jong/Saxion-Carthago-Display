//  createGrid([[1,1],[1,2],[2,1],[2,2]]); //left corner block
// createGrid([[1,2],[1,3],[2,2],[2,3]]); //center block
//  createGrid([[1,1],[1,2],[1,3],[2,1],[2,2],[2,3]]); // right side grid (almost full screen)
// createGrid([[1,1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,3]]); // full screen
// createGrid([[1,1],[2,1],[2,2],[2,3]]); //left side row
//calculate the width of the grid
function calcGridRow(arr) {
    let startVal = arr[0][1];
    let result = 0;
    let highestVal = arr[0][1];
    console.log(arr);
    for (let i = 0; i < arr.length; i++) {
        if (arr[i][1] > startVal) {
            highestVal = arr[i][1];
        }
    }
    result = highestVal - startVal + 1;
    console.log(result);

    return result;
}

//create te grid
function createGrid(box, arr, preview) {
    console.log(arr);
    arr = JSON.parse(arr);
    let maxCol = arr[arr.length - 1][0];
    let maxRow = calcGridRow(arr);
    let str = "" + arr[0][0] + " / " + arr[0][1];
    //get the length of the cols (rows)
    //create the style script for the columns
    str = str + " / span " + maxCol;
    str = str + " / span " + maxRow;

    //select the last index of the first col
    console.log(str);
    //create the columns and rows in the css style
    document.getElementById("box" + box).style.gridArea = str;
    if (preview) {
        document.getElementById("box" + box).classList.remove("BoxPlaceholder");
    }

}

//remove te extra elements
function removeBoxes() {
    var paras = document.getElementsByClassName("BoxPlaceholder");
    while (paras[0]) {
        paras[0].parentNode.removeChild(paras[0]);
    }

}

function CreateDivs(count) {
    console.log("Div Count ", count);
    var paras = document.getElementsByClassName("BoxPlaceholder");
    while (paras[0]) {
        paras[0].parentNode.removeChild(paras[0]);
    }

    for (let i = count + 1; i <= 12; i++) {

        let newEl = document.createElement("div");
        newEl.setAttribute("id", "box" + i);
        newEl.setAttribute("class", "BoxPlaceholder gridBox");


        let parrent = document.getElementById("component-container");
        parrent.appendChild(newEl);


    }
}


function CreateDivsForPreview() {
    var container = document.getElementById("component-container");
    container.innerHTML = "";


    for (let i = 1; i <= 12; i++) {

        let newEl = document.createElement("div");
        newEl.setAttribute("id", "box" + i);
        newEl.setAttribute("class", i + " BoxPlaceholder");
        newEl.setAttribute("onclick", "selectBox(this)");
        newEl.innerHTML = "<h2> Box " + i + "</h2>";

        let parrent = document.getElementById("component-container");
        parrent.appendChild(newEl);


    }
}


function resetVars() {
    var container = null;
    var paras = null;
}