interface ToDo {
    name: string;
    completed?: boolean;
}

interface jQuery {
    (selector: (string | any)): jQueryElement;
    fn: any;
    version: number;
}

interface jQueryElement { 
    data(name: string): any;
    data(name: string, data: any): jQueryElement;

    todo(): ToDo;
}

var todo = { name: "pick up drycleaning" };
var container = $('#container');
container.data('todo', todo);
