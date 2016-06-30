function PolygonArea(x_list,y_list){
/**
  http://www.mathopenref.com/coordpolygonarea.html
 
  x2y2 ------- x1y1
       |     |
       |     |
  x3y3 ------- xnyn
  
  |x  | y |
  ---------
  |x1 | y1|
  |x2 | y2|
  |x3 | y3|
  |  ...  |
  |xn | yn|
  ---------
  area  = ((x1y2-y1x2)+(x2y3-y2x3)+...+(xny1-ynx1))/2
**/
 
  var sum = 0.0;
  var co_num = x_list.length;
  
  for (var i = 0;i<co_num-1;i++){
    sum = sum + (x_list[i]*y_list[i+1]-y_list[i]*x_list[i+1]);
  }
  sum = sum + (x_list[co_num-1]*y_list[0]-y_list[co_num-1]*x_list[0]);
  var result = Math.abs(sum/2);
  
  console.log("result: "+result);
  return result;
}

function CoordinateToXYList(coordinates){
  var x_list = [];
  var y_list = [];
  for (var i=0;i<coordinates.length;i++){
    var item = coordinates[i];
    x_list.push(item[0]);
    y_list.push(item[1]);
  }
  return [x_list,y_list];
}

function main() {
  var test_data = [[1,1],[1,5],[5,5],[5,1]];
  var XYList = CoordinateToXYList(test_data);
  PolygonArea(XYList[0],XYList[1]);
  
  return 'Hello, World!';
}

main();
