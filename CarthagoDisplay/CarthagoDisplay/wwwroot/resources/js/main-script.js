// [[1,2,3,4],[1,2,3,4],[1,2,3,4]]
// 1-2-3-4 = row
// 1-2-3 = col
let selected = [[false, false, false, false], [false, false, false, false], [false, false, false, false]];
let colorCounter = 0;
let colors = [
    "rgba(239, 211, 26, 0.6)", "rgba(244, 174, 26, 0.6)", "rgba(243, 107, 40, 0.6)", "rgba(239, 73, 36, 0.6)",
    "rgba(238, 47, 68, 0.6)", "rgba(236, 70, 139, 0.6)", "rgba(184, 86, 161, 0.6)", "rgba(145, 91, 166, 0.6)",
    "rgba(81, 139, 201, 0.6)", "rgba(39, 190, 182, 0.6)", "rgba(103, 191, 107, 0.6)", "rgba(161, 205, 73, 0.6)"
];
let def = "rgba(0, 0, 0, 0.418)";
let completedGrid = "";
let completeGridArr = [];
let dotNetReference;
let arrRss = [];

function checkValid() {
    let els = document.getElementsByClassName("check-valid");
    for (let i = 0; i < els.length; i++) {
        els[i].reportValidity();
    }
}

function resetValues() {
    selected = [[false, false, false, false], [false, false, false, false], [false, false, false, false]];
    completedGrid = "";
    completeGridArr = [];
    colorCounter = 0;
}

function resetBoxes() {
    let el = document.getElementsByClassName("gridSelect")[0].children;
    for (let element of el) {
        element.style = "background-color: " + def + ";";
        element.disabled = false;
    }
    selected = [[false, false, false, false], [false, false, false, false], [false, false, false, false]];
    colorCounter = 0;
}


//select div
function selectDiv(obj) {

    if (!obj.disabled) {
        let row = obj.id - 1;
        let col = obj.className - 1;

        if (checkSelectedNear(row, col)) {
            obj.style = "background-color:" + colors[colorCounter] + ";";
            obj.disabled = true;
            // obj.className = "active";

        }
    }


}

function setdotNetReference(_dotNetReference) {
    dotNetReference = _dotNetReference;
}

function selectBox(obj) {
    let box = parseInt(obj.className);
    dotNetReference.invokeMethodAsync("SelectBox", box);
}


function makeUsableArray() {
    colorCounter++;
    let arr = selected;
    let newArr = [];
    for (let i = 0; i < arr.length; i++) {
        let col = arr[i];
        let innerArr = [];
        for (let row = 0; row < col.length; row++) {
            let val = col[row];
            if (val == true) {
                newArr.push([i + 1, row + 1]);
            }

        }
    }
    selected = [[false, false, false, false], [false, false, false, false], [false, false, false, false]];
    console.log(newArr);
    completeGridArr.push(newArr);
    console.log(completeGridArr);
    return JSON.stringify(newArr);
}

function arrSelect(row, col) {
    if (selected[row][col] == false) {
        selected[row][col] = true;
    }
    return true;
}

function checkSelectedNear(row, col) {
    select = false;
    if (row > 0) {
        if (selected[row - 1][col] == true) {
            select = true;
        }
    }
    if (col > 0) {
        if (selected[row][col - 1] == true) {
            select = true;
        }
    }
    if (row + 1 < 3) {
        if (selected[row + 1][col] == true) {
            select = true;
        }
    }
    if (col + 1 < 4) {
        if (selected[row][col + 1] == true) {
            select = true;
        }
    }
    if (select == false) {
        select = true;
        for (let i = 0; i < selected.length; i++) {
            for (let k = 0; k < 4; k++) {
                if (selected[i][k] == true) {
                    select = false;
                    break;
                }
            }
        }
    }
    if (select == true) {
        return arrSelect(row, col);
    } else {
        return false;
    }
}


function StartClock() {
    let clock = document.getElementById("clock");
    let date = document.getElementById("date");
    let widthClock = clock.offsetWidth;
    clock.style.fontSize = widthClock + "%";

    function updateDateTime() {

        let d = new Date();
        let dd = String(d.getDate()).padStart(2, "0");
        let mm = String(d.getMonth() + 1).padStart(2, "0");
        let yyyy = d.getFullYear();
        let m = d.getMinutes();
        let h = d.getHours();
        clock.textContent =
            ("0" + h).substr(-2) + ":" + ("0" + m).substr(-2);
        date.textContent = dd + "-" + mm + "-" + yyyy;
    }

    setInterval(updateDateTime, 1000);
}

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

let shownElement = 0;
let shownEmployee = 0;

function flipEmployees() {
    inner();

    function inner() {
        let employees = document.getElementsByClassName("employee-container");
        for (let i = 0; i < employees.length; i++) {

            if (i == shownEmployee) {
                employees[i].style.height = "auto";


            } else {
                employees[i].style.height = "0";
            }

        }
        shownEmployee++;
        if (shownEmployee >= employees.length) {
            shownEmployee = 0;
        }
    }

    setInterval(inner, 10000);
}

function flipFlop(id) {
    inner();

    function inner() {

        let feeds = document.getElementsByClassName("feedGridId" + id);
        for (let i = 0; i < feeds.length; i++) {

            if (i == shownElement) {
                feeds[i].style.height = "auto";


            } else {
                feeds[i].style.height = "0";
            }

        }
        shownElement++;
        if (shownElement >= feeds.length) {
            shownElement = 0;
        }
    }

    if (!arrRss.includes(id)) {
        setInterval(inner, 10000);
        arrRss.push(id);
    }

}

//the time the roomscomponent starts
let startTime = 8;
let timecheck;

function createTimeLabels() {
    let roomEl = document.getElementsByClassName("boxtime");


    SetTime();
    for (let i = 0; i < roomEl.length; i++) {
        let boxTime = startTime;
        let timeString = "";
        for (let k = 0; k < 19; k++) {
            let box = document.createElement("div");
            if (k % 2 == 0) {
                if (boxTime < 10) {
                    timeString = "<span>0" + boxTime + ":00</span>";
                } else {
                    timeString = "<span>" + boxTime + ":00</span>";
                }
                box.innerHTML = timeString;
                boxTime++;
            }

            roomEl[i].appendChild((box));

        }
    }

    function SetTime() {
        let slidercollection = document.getElementsByClassName("time-slider");
        let d = new Date();
        //let d = new Date('August 19, 1975 15:45');
        let h = d.getHours();
        let mNow = d.getMinutes();
        let m = mNow / 60;


        let t = h + m;


        for (let slider of slidercollection) {
            if (t < startTime) {
                slider.style.width = "0%";
            } else if (t >= 17) {
                slider.style.width = "100%";
            } else {

                slider.style.width = ((t - 8) / 9) * 100 + "%";

            }
        }
    }

    setInterval(SetTime, 1000);
}

function ForceCreateGrid() {
    $("#myModal").modal("show");
}

function ResetFlipFlop() {
    arrRss = [];
}