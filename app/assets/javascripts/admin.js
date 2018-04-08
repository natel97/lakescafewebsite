let open = false;

let openClose = () => {
    open ? 
            $("#variables").addClass("hidden-content")
        :
            $("#variables").removeClass("hidden-content")
    open = !open
}