class StatusUpdateMailer < ApplicationMailer

	def status_update_notification(user)
		
		if user.archive?
			mail(to: user.email,
				subject: 'User has been archived')
		elsif user.unarchive?
			mail(to: user.email,
				subject: 'User has been unarchived')
		else
			mail(to: user.email,
				subject: 'User has been deleted')
		end
	end
end
