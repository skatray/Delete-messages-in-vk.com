/**
*
 * NOTICE OF LICENSE
 *
 * Licensed under the Skatray License.
 *
 * @name       Delete messages in vk.com
 * @desc       This script allows you to delete your messages from the VKontakte social network in automatic mode.
 * @version    1.00
 * @author     Volodymyr Nikolaienko
 * @license    Skatray License
 * @copyright  (c) 2021, Skatray, Inc
 * @link       
 */

//Option
let speed = 1.5 //Seconds
let language = lang()
//
//функция в деле
if(window.location.pathname.toLowerCase() =="/im"){
while (document.querySelector('#im_dialogs').children.length!=0) {
	console.log(document.querySelector('#im_dialogs').children.length);
await setPrTimeout(speed*1000)
	let e =	document.querySelector('#im_dialogs').children[0]
	e.children[1].children[0].children[2].click();
	console.log(e.children[1].children[0].children[4].innerText);
//	e.remove();
await setPrTimeout(600)
if(ifDeleteAllMessage()){
await setPrTimeout(500)
}
	document.querySelectorAll("button.flat_button")[1].click();
	language="ru" ? console.log('Удалил'):console.log('Deleted');	
}}else {
language="ru" ? alert('Вы можете использовать этот скрипт только на странице https://vk.com/im. Попробуйте еще раз их.')
:alert("You can use this script only on page https://vk.com/im. Try again them.")
}

//Promise
function setPrTimeout(ms){
	var promise = new Promise((resolve)=>{
		setTimeout(()=>{
			resolve();
	},ms);
	});
	return promise;
}
function lang(){
	var language = window.navigator ? (window.navigator.language ||
		window.navigator.systemLanguage ||
		window.navigator.userLanguage) : "ru";
	return language.substr(0, 2).toLowerCase();
}

function ifDeleteAllMessage(){
	let chetbox = document.querySelector("#box_layer > div.popup_box_container > div > div.box_controls_wrap > div.box_controls > div.box_controls_text._box_controls_text > div")
	if(chetbox){
		chetbox.click()
		return true;
	}else{
		return false
	}
}
