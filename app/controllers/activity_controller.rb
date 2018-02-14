class ActivityController < ApplicationController
  def mine
    client = Instagram.client(access_token: current_user.settings["token"])

    recent_media = client.user_recent_media
    album = [].concat(recent_media)

    max_id = recent_media.pagination.next_max_id

    while !(max_id.to_s.empty?) do
      response = client.user_recent_media(:max_id => max_id)
      max_id = response.pagination.next_max_id
      album.concat(response)
    end

    @album = album

    @paginatable_array = Kaminari.paginate_array(@album).page(params[:page]).per(6)
  end
end
