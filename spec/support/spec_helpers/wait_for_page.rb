module Support
  module SpecHelpers
    module WaitForPage
      def wait_for_ajax(timeout = 30)
        Timeout.timeout(timeout) do
          loop until finished_all_ajax_requests?
        end
      end

      def finished_all_ajax_requests?
        pending_requests = page.evaluate_script('window.calendarPendingRequests')
        pending_requests && pending_requests.zero?
      end
    end
  end
end
