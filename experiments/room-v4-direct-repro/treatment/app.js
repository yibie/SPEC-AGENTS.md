const ROOMS=['Orchid','Cedar','Harbor'], KEY='meeting-room-bookings';
const $=id=>document.getElementById(id), form=$('booking-form'), list=$('list'), error=$('time-error');
let records=JSON.parse(localStorage.getItem(KEY)||'[]'), pendingCancel=null;
ROOMS.forEach((room,i)=>$('room').add(new Option(room,String(i))));
function save(){localStorage.setItem(KEY,JSON.stringify(records));}
function conflict(candidate,ignore){return records.some(x=>x.status==='active'&&x.id!==ignore&&x.date===candidate.date&&x.room===candidate.room&&candidate.start<x.end&&x.start<candidate.end)}
function render(){list.replaceChildren();if(!records.length){list.textContent='No reservations yet.';return}records.forEach(x=>{const article=document.createElement('article');if(x.status==='cancelled')article.className='cancelled';const h=document.createElement('h3');h.textContent=x.topic;const p=document.createElement('p');p.className='meta';p.textContent=`${x.person} · ${x.date} · ${x.start}–${x.end} · ${ROOMS[x.room]}`;article.append(h,p);if(x.status==='cancelled'){const s=document.createElement('p');s.textContent='Cancelled';article.append(s)}else{const edit=document.createElement('button');edit.textContent='Edit';edit.onclick=()=>editRecord(x);const cancel=document.createElement('button');cancel.textContent='Cancel';cancel.onclick=()=>askCancel(x);article.append(edit,cancel)}list.append(article)})}
function values(){return{topic:$('topic').value.trim(),person:$('person').value.trim(),date:$('date').value,start:$('start').value,end:$('end').value,room:$('room').value,status:'active'}}
form.onsubmit=e=>{e.preventDefault();const v=values(), id=$('edit-id').value;if(!v.topic||!v.person||!v.date||!v.start||!v.end||v.end<=v.start){error.textContent='End time must be later than start time.';return}if(conflict(v,id)){error.textContent='This room is already booked for that time.';return}error.textContent='';if(id)records=records.map(x=>x.id===id?{...x,...v}:x);else records.push({id:crypto.randomUUID(),...v});save();form.reset();$('edit-id').value='';$('cancel-edit').hidden=true;render()};
function editRecord(x){for(const k of ['topic','person','date','start','end','room'])$(k).value=x[k];$('edit-id').value=x.id;$('cancel-edit').hidden=false;$('form-title').textContent='Edit reservation';$('topic').focus()}
function askCancel(x){pendingCancel=x; if(typeof $('confirm').showModal==='function')$('confirm').showModal();else if(confirm('Cancel this reservation?'))cancelRecord()}
$('confirm').addEventListener('close',()=>{if($('confirm').returnValue==='yes')cancelRecord();pendingCancel=null});
function cancelRecord(){if(!pendingCancel)return;pendingCancel.status='cancelled';save();render()}
$('cancel-edit').onclick=()=>{form.reset();$('edit-id').value='';$('cancel-edit').hidden=true;$('form-title').textContent='New reservation';error.textContent=''};
render();
