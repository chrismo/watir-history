# Suggested solution to Lab 4: Record Check.
require 'toolkit'

# Start with a user that has no time records. 
ensure_no_user_data 'ruby'
start_ie 
form = forms[0]
form.name = 'ruby'
form.submit
wait

# create a background job
new_job = form{|f| f.action == 'job'}
new_job.name = 'background'
new_job.submit
wait

# create two jobs
new_job = form{|f| f.action == 'job'}
new_job.name = 'job1'
new_job.submit
wait

new_job = form{|f| f.action == 'job'}
new_job.name = 'job2'
new_job.submit
wait

# Record time sessions for two separate jobs, one session for each.
form{|f| f.action == 'start'}.element{|e| e.value == 'job1'}.click
wait
sleep 3
form{|f| f.action == 'start'}.element{|e| e.value == 'job2'}.click
wait
sleep 3
form{|f| f.action == 'pause_or_stop_job'}.elements('quick_stop').click
wait
form{|f| f.action == 'pause_or_stop_day'}.elements('stop_day').click
wait

# Verify that two time records appear.
assert_total_job_records 2

# Verify the time records
assert_job_record 1, 'job2', ''
assert_job_record 2, 'job1', ''

    
  


