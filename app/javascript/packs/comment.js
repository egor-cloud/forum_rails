document.addEventListener("turbolinks:load", () => {

  let comment_buttons = []

  const el = document.querySelectorAll("[data-answer]")
  const response = document.querySelectorAll(".add_comment_to_comment")

  const getTemplate = (answer_id, user_id, category_id) => {
    return `
    <div class="container containerComment">
      <div class="row justify-content-center" style="margin-top: 50px">
        <div class="col-9">
          <form id="new_comment" action="/comments" accept-charset="UTF-8" data-remote="true" method="post"><input type="hidden" name="authenticity_token" value="o3hGKCwACCOc+gbwmX/V1eCCmCq1XEzIyhzU3ejJmGCNMhZ6QSn9CgVKZxxuyxd3LaS0sO+h5ZCHnHyZj8dS2g==">
            <div class="form-group">
              <label for="comment_Your_comment">Your comment</label>
              <textarea class="form-control" style="max-height: 300px" name="comment[body]" id="comment_body"></textarea>
            </div>
            <input value="${user_id}" type="hidden" name="comment[user_id]" id="comment_user_id">
            <input value="${answer_id}" type="hidden" name="comment[answer_id]" id="comment_answer_id">
            <input value="${category_id}" type="hidden" name="comment[category_id]" id="comment_category_id">
            <div class="form-group text-right">
              <input type="submit" name="commit" value="comment" class="btn btn-primary" data-disable-with="comment">
            </div>
          </form>
         </div>
      </div>
    </div>
    `
  }

  const getTemplateChildren = (parent_id, user_id, answer_id) => {
    return `
    <div class="container containerComment">
      <div class="row justify-content-center" style="margin-top: 50px">
        <div class="col-9">
          <form id="new_comment" action="/comments/${parent_id}/create_children" accept-charset="UTF-8" data-remote="true" method="post"><input type="hidden" name="authenticity_token" value="o3hGKCwACCOc+gbwmX/V1eCCmCq1XEzIyhzU3ejJmGCNMhZ6QSn9CgVKZxxuyxd3LaS0sO+h5ZCHnHyZj8dS2g==">
            <div class="form-group">
              <label for="comment_Your_comment">Your comment</label>
              <textarea class="form-control" style="max-height: 300px" name="comment[body]" id="comment_body"></textarea>
            </div>
            <input value="${user_id}" type="hidden" name="comment[user_id]" id="comment_user_id">
            <input value="${answer_id}" type="hidden" name="comment[answer_id]" id="comment_answer_id">
            <input value="${parent_id}" type="hidden" name="comment[parent_id]" id="comment_parent_id">
            <div class="form-group text-right">
              <input type="submit" name="commit" value="comment" class="btn btn-primary" data-disable-with="comment">
            </div>
          </form>
         </div>
      </div>
    </div>
    `
  }

  function blabla(){
    return
  }

  function is_the_a_comment(){
    if(document.querySelector("#new_comment") != null && document.querySelector(".containerComment") != null ){
      const containerComment = document.querySelector(".containerComment")
      containerComment.parentNode.removeChild(containerComment)
    }else{
      blabla()
    }
  }


  if(el.length){
    for(let i of el){
      i.onclick = function(e){
        e.preventDefault()
        let dataButton = e.target.getAttribute('data-answer')
        let dataAnswerAfter = e.target.parentElement.parentElement.parentElement.parentElement
        is_the_a_comment()
        let container = document.createElement('div');
        container.classList.add("container")
        container.classList.add("containerComment")
        // Для разнообразия добавим скрытые инпуты с id user и post id, мы же хакеры
        container.insertAdjacentHTML("afterbegin", getTemplate(dataButton, user_id, category_id))
        dataAnswerAfter.appendChild(container);
      }
    }
  }

  if(response.length){
    for(let i of response){
      i.onclick = function(e){
        e.preventDefault()
        let dataButton = e.target.getAttribute('data-comment')
        let dataAnswer = e.target.getAttribute('data-comment-to-answer')
        let dataCommentAfter = e.target.parentElement.parentElement.parentElement
        is_the_a_comment()
        let container = document.createElement('div');
        container.classList.add("container")
        container.classList.add("containerComment")
        // Для разнообразия добавим скрытые инпуты с id user и post id, мы же хакеры
        container.insertAdjacentHTML("afterbegin", getTemplateChildren(dataButton, user_id, dataAnswer))
        dataCommentAfter.appendChild(container);
      }
    }
  }

  document.onclick = function (e) {

    if(document.querySelector("#new_comment") != null && document.querySelector(".containerComment") != null ){
      const comment = document.querySelector("#new_comment")
      const containerComment = document.querySelector(".containerComment")
      el.forEach((element) => {
        if (element.contains(e.target) == true){
          comment_buttons = element
        }
      })
      response.forEach((element) => {
        if (element.contains(e.target) == true){
          comment_buttons = element
        }
      })
      if (!comment.contains(e.target) && !comment_buttons.contains(e.target)) {
        containerComment.parentNode.removeChild(containerComment)
        return true
      }
    }else{
      blabla()
    }
  }
});


