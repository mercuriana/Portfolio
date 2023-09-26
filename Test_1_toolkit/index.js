// ---------------------------------------------------------------
// Pie Plot Code
// ---------------------------------------------------------------

var team = document.getElementById('team').value
var community = document.getElementById('community').value
var investors = document.getElementById('investors').value
var sale = document.getElementById('sale').value

var teamtxt = document.getElementById('teamtxt').value
var commtxt = document.getElementById('commtxt').value
var invtxt = document.getElementById('invtxt').value
var saletxt = document.getElementById('saletxt').value

const ctx = document.getElementById('myChart');
const data = {
    labels: [
        teamtxt,
        commtxt,
        invtxt,
        saletxt
    ],
    options: {  legend: false},
    datasets: [{
        label: 'My First Dataset',
        data: [team,community,investors, sale],
        backgroundColor: [
        'rgb(255, 99, 132)',
        'rgb(54, 162, 235)',
        'rgb(255, 205, 86)',
        'rgb(128, 0, 128)'
    ],
    hoverOffset: 4
    }]
    };

const config = {
type: 'doughnut',
data: data,
};

var dona = new Chart(ctx, config);

function updateChart() {
    var team = document.getElementById('team').value
    var community = document.getElementById('community').value
    var investors = document.getElementById('investors').value
    var sale = document.getElementById('sale').value

    var teamtxt = document.getElementById('teamtxt').value
    var commtxt = document.getElementById('commtxt').value
    var invtxt = document.getElementById('invtxt').value
    var saletxt = document.getElementById('saletxt').value


    var updateValues = [team, community, investors, sale];
    var updateLabels = [teamtxt, commtxt, invtxt, saletxt];

    dona.data.datasets[0].data = updateValues;
    dona.data.labels = updateLabels;
    dona.update();
}
document.getElementById('label1').style.color = dona.data.datasets[0].backgroundColor[0];
document.getElementById('label2').style.color = dona.data.datasets[0].backgroundColor[1];
document.getElementById('label3').style.color = dona.data.datasets[0].backgroundColor[2];
document.getElementById('label4').style.color = dona.data.datasets[0].backgroundColor[3];








// overrides: {
//     doughnut: {
//         plugins: {
//             legend: {
//                 display: false,
//             }
//         }
//     }
// }