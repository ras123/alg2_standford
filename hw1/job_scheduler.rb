firstLine = true
schedule = []
ARGF.each do |line|
  if firstLine
    firstLine = false
    next
  end

  job = {}
  weight, length = line.split(" ")
  job["weight"] = weight.to_i
  job["length"] = length.to_i
  schedule << job 
end

# Compute the weighted sum of completion times
def computeCompletionTimes(schedule)
  completionTime = 0
  completionTimesSum = 0
  schedule.each do |job|
    completionTime  = completionTime + job["length"]
    completionTimesSum = completionTimesSum + job["weight"] * completionTime
  end

  puts completionTimesSum
end

# Sort the jobs in decreasing order of (weight - length)
schedule.sort! do |jobA, jobB|
  jobADiff = jobA["weight"] - jobA["length"]
  jobBDiff = jobB["weight"] - jobB["length"]
  case
  when jobADiff > jobBDiff
    -1
  when jobBDiff > jobADiff
    1
  else
    jobA["weight"] > jobB["weight"] ? -1 : 1
  end
end

computeCompletionTimes(schedule)

# Sort the jobs in decreasing order of ratio (weight / length)
schedule.sort! do |jobA, jobB|
  jobARatio = jobA["weight"] / jobA["length"].to_f
  jobBRatio = jobB["weight"] / jobB["length"].to_f
  case
  when jobARatio > jobBRatio
    -1
  when jobBRatio > jobARatio
    1
  else
    jobA["weight"] > jobB["weight"] ? -1 : 1
  end
end

computeCompletionTimes(schedule)
