$(document).ready(function(){
    // $('#page-wrapper').mouseenter(function() {
    //     alert("MouseEnter!"); // This will create an alert box
    //     console.log("MouseEnter!"); // This will log to the JS console on your browser which is a bit nicer to read than alerts, you do not need both, just preference
    //     $(this).fadeIn('fast',1);
    // })

    // $('#page-wrapper').mouseleave(function(){
    //     alert("MouseLeave!"); // This will create an alert box
    //     console.log("MouseLeave!");
    //     $(this).fadeIn('fast',0.5);
    // })

	var user = $('#wrapper').data();
	console.log(user);
	if (user.userPresent == false ) {
		console.log("no User");
		$('#page-wrapper').css('margin', '0 0 0 0');
	};
});