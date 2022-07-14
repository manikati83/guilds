class QuestMembersController < ApplicationController
  def create
    @quest = Quest.find(params[:quest_id])
    if @quest.guild.members.include?(current_user)
      if @quest.quest_members.empty?
        current_user.quest_members.find_or_create_by(quest_id: @quest.id, leader: true)
        flash[:success] = "クエストを受注しました。"
        redirect_to @quest
      else
        current_user.quest_members.find_or_create_by(quest_id: @quest.id)
        flash[:success] = "クエストに参加しました。"
        redirect_to @quest
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @quest = Quest.find(params[:quest_id])
    join_quest = current_user.quest_members.find_by(quest_id: @quest.id)
    if join_quest
      if join_quest.leader
        join_quest.destroy
        if !@quest.members.empty?
          new_leader = @quest.quest_members.first
          new_leader.update(leader: true)
        end
        flash[:success] = 'クエストの参加を取り消しました。'
        redirect_to @quest
      else
        join_quest.destroy
        flash[:success] = 'クエストの参加を取り消しました。'
        redirect_to @quest
      end
    end
  end
end
