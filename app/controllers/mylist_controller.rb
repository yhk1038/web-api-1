class MylistController < ApplicationController

    def add
        id = params[:id]

        s = Song.where(id: id).first
        if s.nil?
            flash[:error] = "존재하지 않은 곡입니다."
            redirect_to :back
            return false
        end

        m = MylistSong.new
        m.song_id = s.id
        if current_user.mylists.where(title: "Default").first.nil?
            a = Mylist.new
            a.user_id = current_user.id
            a.title = "Default"
            a.save
        end

        m.mylist_id = Mylist.where(title: "Default").first.id
        m.save

        # render text: "추가 완료 추가된 곡 :" + m.song.title
        flash[:error] = "추가 완료 추가된 곡 :" + m.song.title
        redirect_to :back
    end

    def delete
        MylistSong.find(params[:id]).destroy
        redirect_to :back
    end


end
